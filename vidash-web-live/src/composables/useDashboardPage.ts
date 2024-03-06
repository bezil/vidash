import { computed, ref } from 'vue';
import { User, Member, NavigationItem } from '@/types/common.ts'
import axios from '@/axios';
import useStore from '@/store/useStore'

const useDashboardPage = () => {
    const current_user = ref<User>()
    const member = ref<Member>()
    const current_navigation = ref('home')
    const isMemberLoading = ref(false)

    const { account_id, storeUserDetails, storeMemberDetails } = useStore()

    const updateActiveNavigationItem = (menu: string) => {
      current_navigation.value = menu
    }

    const activeNavigationItem = (menu: string): NavigationItem | null => {
      if (!menu
        || !['home', 'restore', 'fill', 'obj_remove', 'recolor', 'bg_remove', 'profile', 'credits']
      .includes(menu)) {
        return null
      }
      if (menu === 'home') {
        return {
          id: 'home',
          title: 'Home',
          subtitle: 'Unlock Top-Class AI Tools Now!'
        }
      } else if (menu === 'restore') {
        return {
          id: 'restore',
          title: 'Restore',
          subtitle: 'Refine your images with precision by eliminating noise and imperfections effortlessly.'
        }
      } else if (menu === 'fill') {
        return {
          id: 'fill',
          title: 'Generative Fill',
          subtitle: 'Enhance image dimensions seamlessly using advanced AI outpainting technology.'
        }
      } else if (menu === 'obj_remove') {
        return {
          id: 'obj_remove',
          title: 'Object Remove',
          subtitle: 'Enhance the focus and aesthetics of your images by effortlessly removing distractions and refining the composition with precision.'
        }
      } else if (menu === 'recolor') {
        return {
          id: 'recolor',
          title: 'Object Recolor',
          subtitle: 'Easily identify objects within images using natural language and dynamically alter their colors to suit your preferences.'
        }
      } else if (menu === 'bg_remove') {
        return {
          id: 'bg_remove',
          title: 'Background Remove',
          subtitle: 'Effortlessly remove backgrounds from your images using advanced AI technology.'
        }
      } else if (menu === 'profile') {
        return {
          id: 'profile',
          title: 'Profile',
          subtitle: 'Change user details'
        }
      } else if (menu === 'credits') {
        return {
          id: 'credits',
          title: 'Credits',
          subtitle: 'Change subscription details'
        }
      } else {
        return null
      }
    }

    const currentNavigationItem = computed(() => activeNavigationItem(current_navigation.value))

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
        currentNavigationItem,
        updateActiveNavigationItem,
        initializeDashboardPage,
        fetchUserAccount,
    }
}

export default useDashboardPage
