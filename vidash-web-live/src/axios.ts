import axios from "axios";

if (process.env.NODE_ENV === 'production') {
// Production base URL
axios.defaults.baseURL = 'https://api.vidash.live/';
} else {
// Development base URL
axios.defaults.baseURL = 'http://localhost:5000/';
}
axios.defaults.headers.common['Authorization'] = 'Bearer ' + localStorage.getItem('token')

export default axios
