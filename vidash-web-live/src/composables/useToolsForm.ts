import { type CloudinaryImage } from "@cloudinary/url-gen"
// import axios from '@/axios'

type AllImageObject = {
old: CloudinaryImage,
new:  CloudinaryImage,
}

const useToolsForm = () => {

    const saveToDatabase = (images: AllImageObject) => {
    console.log(images, '---')
    // axios.post('api/images/add', {
    //     image: {
    //       title: null,
    //       type: null,
    //       secure_url: images.old.toURL(),
    //       public_id: images.new.publicID,
    //       config: null,
    //       width: '',
    //       height: '',
    //       transformation_url: images.new.toURL(),
    //       aspect_ratio: '',
    //       prompt: null,
    //       color: null,
    //       author: null,
    //     }
    //   })
    //   .then(() => {
    //   })
    //   .catch(error => console.error('Error:', error));
    }

    return {
        saveToDatabase,
    }
}

export default useToolsForm
