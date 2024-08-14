import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Users from '../views/users/Users.vue'
import User from '../views/users/User.vue'
import Services from '../views/services/Services.vue'
import Service from '../views/services/Service.vue'

const routes = [
  {
    path: '/',
    name: 'Login',
    component: Login
  },
  {
    path: '/users',
    name: 'Users',
    component: Users
  },
  {
    path: '/users/:id',
    name: 'User',
    component: User
  },
  {
    path: '/services',
    name: 'Services',
    component: Services
  },
  {
    path: '/services/:id',
    name: 'Service',
    component: Service
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
