import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Users from '../views/Users.vue'

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
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
