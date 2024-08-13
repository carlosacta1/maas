import axios from 'axios';

const API_URL = "http://localhost:3000"

const axiosSecureInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  }
});

export default axiosSecureInstance;
