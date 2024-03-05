import { createRouter, createWebHistory } from 'vue-router';
import Dashboard from './components/pages/Dashboard.vue';
import Home from './components/pages/Home.vue';
import Manage from './components/pages/Manage.vue';
import Playground from './components/pages/Playground.vue';
import Credits from './components/pages/Credits.vue';
import Transpose from './components/pages/Transpose.vue';
import Profile from './components/pages/Profile.vue';
import Register from './components/pages/Register.vue';
import Login from './components/pages/Login.vue';

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/',  name: 'home', component: Home,
        },
        {
          path: '/play', name: 'play', component: Playground,
        },
        {
          path: '/dash', component: Dashboard,
          meta: { requiresAuth: true }
        },
        {
          path: '/profile', component: Profile,
          meta: { requiresAuth: true }
        },
        {
          path: '/transpose', component: Transpose,
          meta: { requiresAuth: true }
        },
        {
          path: '/credits', component: Credits,
          meta: { requiresAuth: true }
        },
        {
          path: '/manage', component: Manage,
          meta: { requiresAuth: true }
        },
        {
          path: '/signup', name: 'Register', component: Register,
        },
        {
          path: '/signin', name: 'Login', component: Login,
        },
        { path: '/:pathMatch(.*)*', component: Home }
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
