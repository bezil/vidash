import { ref } from 'vue';
import { User, Server } from '@/types/common.ts'
import { defineStore } from 'pinia'

const useStore = defineStore('common', () => {
    const user = ref<User>();
    const server = ref<Server>()
    const account_id = ref(localStorage.getItem('auth_id'))

    const storeUserDetails = (userDetails: User) => {
        user.value = userDetails
    }

    const storeServerDetails = (serverDetails: Server) => {
        server.value = serverDetails
    }

    const resetStore = () => {
        user.value = undefined
        server.value = undefined
    }

    return {
        account_id,
        user,
        server,
        storeUserDetails,
        storeServerDetails,
        resetStore,
    }
})

export default useStore
