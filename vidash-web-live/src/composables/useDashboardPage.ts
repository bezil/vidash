import { ref } from 'vue';
import { User, Server } from '@/types/common.ts'
import axios from '@/axios';
import useStore from '@/store/useStore'

const useDashboardPage = () => {
    const current_user = ref<User>()
    const user_server = ref<Server>()

    const isServerLoading = ref(true);
    const isServerAlreadySetup = ref(false)

    const { account_id, storeUserDetails, storeServerDetails } = useStore()

    const fetchUserAccount = async () => {
        const response = await axios.get(`api/users/${account_id}`)

        if(response) {
            current_user.value = response.data.details
        }

        if(!!current_user.value) {
          storeUserDetails(current_user.value)
        }
    }

    const fetchServerDetails = async () => {
        isServerLoading.value = true

        const response = await axios.get(`api/servers/by_user_id/${current_user.value?.id}`)
          .catch(() => console.log("No server found"))

        if(response) {
          console.log(response.data.details)
          isServerAlreadySetup.value = true;
          user_server.value = response.data.details
        }

        if(!!user_server.value) {
          storeServerDetails(user_server.value)
        }

        isServerLoading.value = false
      }

    const initializeDashboardPage = async () => {
        await fetchUserAccount()
        fetchServerDetails()
    }

    return {
        current_user,
        user_server,
        isServerLoading,
        isServerAlreadySetup,

        initializeDashboardPage,
        fetchUserAccount,
    }
}

export default useDashboardPage
