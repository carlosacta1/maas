import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Users from '../views/Users.vue'
import Services from '../views/Services.vue'
import { plainAxiosInstance } from '../axios.js'

const routes = [
  {
    path: '/',
    name: 'Login',
    component: Login
  },
  {
    path: '/users',
    name: 'Users',
    component: Users,
    meta: { requiresAuth: true }
  },
  {
    path: '/services',
    name: 'Services',
    component: Services,
    meta: { requiresAuth: true }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach(async (to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    try {
      await plainAxiosInstance.get('/verify-token')
      next()
    } catch (error) {
      next('/')
    }
  } else {
    next()
  }
})

export default router
