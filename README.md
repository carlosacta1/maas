# Monitoring as a Service (MAAS)

This is a Ruby on Rails application that serves as an API with a PostgreSQL database. The frontend is built using Vue.js and is located within the client directory of this repository.

## Overview
Monitoring as a Service (MAAS) is designed to streamline the assignment of shifts to monitoring services. The application allows the creation of services, to which monitoring requests (monitoring_requests) are generated. These requests are then assigned to users through an algorithm that ensures shifts are evenly distributed, minimizing shift changes and balancing the number of hours assigned to each user.

## Features
* Service Management: Create and manage services that require monitoring.
* Monitoring Requests: Automatically generate monitoring requests for each service.
* User Assignment Algorithm: A sophisticated algorithm that assigns users to monitoring requests, minimizing shift changes and ensuring an equitable distribution of hours.
* User Availability: Handle user availability dynamically to ensure that only available users are assigned to monitoring requests.

# Getting Started
* Prerequisites
* Ruby: Version 3.0.0 or later
* Rails: Version 7.0.0 or later
* PostgreSQL: Version 12 or later
* Node.js: Version 14.0.0 or later (for the frontend)
