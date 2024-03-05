import { ref } from 'vue';
import { User, Member } from '@/types/common.ts'
import axios from '@/axios';
import useStore from '@/store/useStore'

const useDashboardPage = () => {
    const current_user = ref<User>()
    const member = ref<Member>()
    const current_navigation = ref()
    const isMemberLoading = ref(false)

    const { account_id, storeUserDetails, storeMemberDetails } = useStore()

    const updateActiveNavigationItem = (menu: string) => {
      current_navigation.value = menu
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

    const fetchMemberDetails = async () => {
      isMemberLoading.value = true

      const response = await axios.get(`api/members/by_user_id/${current_user.value?.id}`)
        .catch(() => console.log("No member found"))

      if(response) {
        member.value = response.data.details
      }

      if(!!member.value) {
        storeMemberDetails(member.value)
      }

      isMemberLoading.value = false
  }

    const initializeDashboardPage = async () => {
      await fetchUserAccount()
      fetchMemberDetails()
    }

    return {
        member,
        current_user,
        current_navigation,
        updateActiveNavigationItem,
        initializeDashboardPage,
        fetchUserAccount,
    }
}

export default useDashboardPage
