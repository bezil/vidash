import { ref } from 'vue';
import { User, Server } from '@/types/common.ts'
import axios from '@/axios';
import useStore from '@/store/useStore'

const useDashboardPage = () => {
    const current_user = ref<User>()
    const user_servers = ref<Server[]>()
    const active_server = ref<Server>()

    const { account_id, storeUserDetails } = useStore()

    const updateActiveServer = (server_id: string) => {
      active_server.value = user_servers.value?.find((server) => server.id === server_id)
    }

    const fetchUserAccount = async () => {
        const response = await axios.get(`api/users/${account_id}`)

        if(response) {
            current_user.value = response.data.details
        }

        if(!!current_user.value) {
          storeUserDetails(current_user.value)
        }
    }

    const initializeDashboardPage = async () => {
      fetchUserAccount()
    }

    return {
        active_server,
        current_user,
        user_servers,
        updateActiveServer,
        initializeDashboardPage,
        fetchUserAccount,
    }
}

export default useDashboardPage
