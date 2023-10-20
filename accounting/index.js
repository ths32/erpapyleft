import axios from 'axios';

function vueListAxios(url, params) {
  return axios.post(url, params);
}

export { vueListAxios };
