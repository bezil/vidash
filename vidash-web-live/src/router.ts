import { createRouter, createWebHistory } from 'vue-router';
import Dashboard from './components/pages/Dashboard.vue';
import Home from './components/pages/Home.vue';
import Register from './components/pages/Register.vue';
import Login from './components/pages/Login.vue';
import Live from './components/live/Live.vue';

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/', component: Home,
        },
        {
          path: '/dashboard', component: Dashboard,
          meta: { requiresAuth: true }
        },
        {
          path: '/dashboard/live', component: Live,
          meta: { requiresAuth: true }
        },
        {
            path: '/signup', component: Register,
        },
        {
            path: '/signin',
            component: Login,
            name: 'Login',
        },
    ],
    strict: true, // applies to all routes
});

 // Global navigation guard
router.beforeEach((to, _from, next) => {
    // Check if the route requires authentication
    if (to.matched.some(record => record.meta.requiresAuth)) {
      // Check if there's a token in localStorage
      const token = localStorage.getItem('token');

      if (!token) {
        // No token found, redirect to login page
        next({ name: 'Login' });
      } else {
        // Proceed to the requested route
        next();
      }
    } else {
      // Proceed to the requested route for public routes
      next();
    }
  });

export default router;
