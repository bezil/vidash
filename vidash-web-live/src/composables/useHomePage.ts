import { ref } from 'vue';
import { User, Server } from '@/types/common.ts'
import axios from '@/axios';
import useStore from '@/store/useStore'

const useHomePage = () => {
    const current_user = ref<User>()
    const user_server = ref<Server>()

    const isServerLoading = ref(true);
    const isServerAlreadySetup = ref(false)

    const { account_id, storeUserDetails } = useStore()

    const fetchUserAccount = async () => {
        const response = await axios.get(`api/users/${account_id}`)

        if(response) {
            current_user.value = response.data.details
        }

        if(!!current_user.value) {
          storeUserDetails(current_user.value)
        }
    }

    const initializeHomePage = async () => {
    }

    return {
        current_user,
        user_server,
        isServerLoading,
        isServerAlreadySetup,

        initializeHomePage,
        fetchUserAccount,
    }
}

export default useHomePage
