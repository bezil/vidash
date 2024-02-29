import { useRoute } from 'vue-router'

const useRouteUtils = ()  => {
    const route = useRoute()

    return {
        route,
    }
}

export default useRouteUtils
