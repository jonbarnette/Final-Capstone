import axios from 'axios';

// const http = axios.create({
//   baseURL: "http://localhost:8080"
// });

export default {

    getCatList() {
        return axios.get('/cats')
    },

    getCatDetails(catId) {
        console.log(catId)
        return axios.get('/cats/' + catId)
    },

    addCat(cat) {
        return axios.post('/cats', cat)
    },

    deleteCat(catId) {
        console.log('delete' + catId)
        return axios.delete('/cats/' + catId)
    },
    msgCat(cat) {
        console.log(cat.catId)
        console.log(cat.sender)
        console.log(cat.message)
        return axios.post('/message', cat)
    },
    getCatMsg(catId) {
        
        console.log('msg-' + catId)
        return axios.get('/message/' + catId)
    },


}