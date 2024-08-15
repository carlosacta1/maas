# Monitoring as a Service (MAAS)

This is a Ruby on Rails application that serves as an API with a PostgreSQL database. The frontend is built using Vue.js and is located inside the client directory of this repository.

The application makes use of the `devise-jwt` gem for login through tokens and cookies, additionally the dotenv gem is used to store the system environment variables.

## Overview
Monitoring as a Service (MAAS) is designed to streamline the assignment of shifts to monitoring services. The application allows the creation of services, to which monitoring requests (monitoring_requests) are generated. These requests are then assigned to users through an algorithm that ensures shifts are evenly distributed, minimizing shift changes and balancing the number of hours assigned to each user.

## Features
* Service Management: Create and manage services that require monitoring.
* Monitoring Requests: Generate monitoring requests for each service.
* User Assignment Algorithm: A sophisticated algorithm that assigns users to monitoring requests, minimizing shift changes and ensuring an equitable distribution of hours.
* User Availability: Handle user availability dynamically to ensure that only available users are assigned to monitoring requests.
* User management: Update and modify user attributes quickly and easily.

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
4. **Setup de jwt env secret key**
   * Create a file called `.env` in the root path of the project
   * Set a variable called `JWT_SECRET_KEY`, the value of the variable can be assigned using rails, then copy and paste the value and assign it to the variable

     
   ```bash
    rails secret
   ```
   
6. **Run the Rails server:**

    ```bash
    rails s
    ```

7. **Run the frontend server:**

    ```bash
    npm run dev --prefix client
    ```
# Usage

* Navigate to http://localhost:3000 for the Rails API.
* The Vue.js frontend is accessible at http://localhost:5173.
* Sign in to start creating and updating the monitoring systems
  
    * You can either create a new user using the rails console or use any of the users created on the seeds

## API Endpoints
* Services:

  * GET /api/v1/services - List all services
  * POST /api/v1/services - Create a new service
  * GET /api/v1/services/:id - Retrieve a specific service
  * PUT /api/v1/services/:id - Update a specific service
  * PATCH /api/v1/services/:id - Update a specific service
  * DELETE /api/v1/services/:id - Delete a specific service
 
  * Monitoring Requests
      * GET /api/v1/services/:service_id/monitoring_requests - List monitoring requests of a specific service
      * POST /api/v1/services/:service_id/monitoring_requests - Create a new monitoring request of a specific service

* Users:

  * GET /api/v1/users - List all services
  * POST /api/v1/users - Create a new service
  * GET /api/v1/users/:id - Retrieve a specific service
  * PUT /api/v1/users/:id - Update a specific service
  * PATCH /api/v1/users/:id - Update a specific service
  * DELETE /api/v1/users/:id - Delete a specific service
 
  * Monitoring Requests
      * GET /api/v1/users/:service_id/monitoring_requests - List monitoring requests of a specific service

# Frontend Structure

The Vue.js frontend is located in the `client` directory and is structured as follows:

* Components: Reusable Vue components.
* Views: Application pages.
* Store: Vuex store for state management.
* Router: Vue Router for managing application routes.

## Frontend Setup

### Tailwind CSS Configuration

Tailwind CSS has been installed and configured for the frontend. Here is the configuration used in `tailwind.config.js`:

```javascript
const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './index.html',
    './public/*.html',
    './src/**/*.{vue,js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Gellix', ...defaultTheme.fontFamily.sans],
        mono: ['Roboto Mono', ...defaultTheme.fontFamily.mono],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
}; 
