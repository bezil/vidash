import { type CloudinaryImage } from "@cloudinary/url-gen"
import axios from '@/axios'
import useStore from '@/store/useStore'

type AllImageObject = {
    old: CloudinaryImage,
    new:  CloudinaryImage,
    aspect_ratio: string,
    title: string,
}

const useToolsForm = () => {
    const { member } = useStore()

    const saveToDatabase = (images: AllImageObject) => {
    console.log(images, '---')
    axios.post('api/images/add', {
        image: {
          title: null,
          type: null,
          secure_url: images.old.toURL(),
          public_id: '',
          config: null,
          width: '',
          height: '',
          transformation_url: images.new.toURL(),
          aspect_ratio: images.aspect_ratio ?? '',
          prompt: null,
          color: null,
          author: member?.id,
        }
      })
      .then(() => {
      })
      .catch(error => console.error('Error:', error));
    }

    return {
        saveToDatabase,
    }
}

export default useToolsForm
