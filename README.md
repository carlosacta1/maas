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

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/carlosacta1/maas.git
    cd maas
    ```

2. **Install dependencies:**

    ```bash
    bundle install
    npm install --prefix client
    ```

3. **Set up the database:**

    ```bash
    rails db:create
    rails db:migrate
    ```

4. **Run the Rails server:**

    ```bash
    rails s
    ```

5. **Run the frontend server:**

    ```bash
    npm run dev --prefix client
    ```
# Usage

* Navigate to http://localhost:3000 for the Rails API.
* The Vue.js frontend is accessible at http://localhost:5173.

# API Endpoints
* Services:

  * GET /services - List all services
  * POST /services - Create a new service
  * GET /services/:id - Retrieve a specific service
    
* Monitoring Requests:

  * GET /monitoring_requests - List all monitoring requests
  * POST /monitoring_requests - Create a new monitoring request
  * GET /monitoring_requests/:id - Retrieve a specific monitoring request

* User Assignments:

  * POST /assignments - Assign users to monitoring requests based on the algorithm

# Frontend Structure

The Vue.js frontend is located in the `client` directory and is structured as follows:

* Components: Reusable Vue components.
* Views: Application pages.
* Store: Vuex store for state management.
* Router: Vue Router for managing application routes.
