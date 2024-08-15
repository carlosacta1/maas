module MonitoringRequests
  class AssignUsers
    class Error < StandardError; end
    include ActiveModel::Model

    attr_accessor :monitoring_requests

    def initialize(**args)
      @monitoring_requests = args[:monitoring_requests] || MonitoringRequest.where(user_id: nil)
    end

    def perform
      begin
        ActiveRecord::Base.transaction do
          assign_users!
        end
      rescue => e
        raise Error, e.message
      else
        true
      end
    end

    private

    def assign_users!
      grouped_requests = @monitoring_requests.group_by { |request| [request.service_id, request.start_time] }

      grouped_requests.each do |(service_id, date), requests|
        # Filter users that are available and not already assigned to a request at the given date
        available_users = User.joins(:availabilities)
                              .where(availabilities: { temporarily_unavailable: false })
                              .select do |user| 
                                user.availabilities.any? { |availability| availability.overlaps?(date) } &&
                                !user.any_monitoring_requests_at?(date)
                              end

        # Calculate total hours assigned to each user for the given service and date
        user_hours = available_users.map do |user|
          total_hours = MonitoringRequest.where(user: user, service_id: service_id, start_time: date.beginning_of_day..date.end_of_day)
                                         .sum { |req| req.end_time - req.start_time }
          [user, total_hours]
        end.to_h

        # Oder users by total hours assigned and then by user id
        sorted_users = user_hours.sort_by { |user, hours| [hours, user.id] }.map(&:first)

        # Assign users to requests
        requests.each do |request|
          user_to_assign = sorted_users.find do |user|
            !user.any_monitoring_requests_at?(request.start_time)
          end
          
          if user_to_assign
            request.update!(user: user_to_assign)
          end
        end
      end
    end
  end
end