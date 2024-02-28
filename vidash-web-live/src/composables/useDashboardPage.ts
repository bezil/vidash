import { ref } from 'vue';
import { User, Server } from '@/types/common.ts'
import axios from '@/axios';
import useStore from '@/store/useStore'

const useDashboardPage = () => {
    const current_user = ref<User>()
    const user_servers = ref<Server[]>()
    const active_server = ref<Server>()

    const isServerLoading = ref(true);
    const isServerAlreadySetup = ref(false)
    const isNewServerNeeded = ref(false)

    const { account_id, storeUserDetails, storeServerDetails } = useStore()

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

    const deleteActiveServer = async (id: string) => {
      const response = await axios.delete(`api/servers/${id}`)

      if(response.status === 204) {
        console.log('Deleted server')
        active_server.value = undefined
        fetchServerDetails();
      }
    }

    const fetchServerDetails = async () => {
        isServerLoading.value = true

        const response = await axios.get(`api/servers/by_user_id/${current_user.value?.id}`)
          .catch(() => console.log("No server found"))

        if(response) {
          console.log(response.data)
          isServerAlreadySetup.value = true;
          user_servers.value = response.data.servers
        }

        if(!!user_servers.value && user_servers.value.length > 0) {
          storeServerDetails(user_servers.value)
        }

        isServerLoading.value = false
      }

    const initializeDashboardPage = async () => {
        await fetchUserAccount()
        fetchServerDetails()
    }

    return {
        active_server,
        current_user,
        user_servers,
        isServerLoading,
        isServerAlreadySetup,
        isNewServerNeeded,
        updateActiveServer,
        initializeDashboardPage,
        fetchUserAccount,
        deleteActiveServer,
    }
}

export default useDashboardPage
