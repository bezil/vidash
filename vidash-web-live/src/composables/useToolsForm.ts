import { type CloudinaryImage } from "@cloudinary/url-gen"

type AllImageObject = {
old: CloudinaryImage,
new:  CloudinaryImage,
}

const useToolsForm = () => {

    const saveToDatabase = (images: AllImageObject) => {
    console.log(images, '---')
    }

    return {
        saveToDatabase,
    }
}

export default useToolsForm
