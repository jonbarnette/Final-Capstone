import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));

if(currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    token: currentToken || '',
    user: currentUser || {},
    catlist: [ {
      
      name: 'Puma Thurman',
      age: '15',
      occupation: 'plumber',
      description: 'unclogging drains is my idea of a dream job',
      imageName: require('../Assets/CatUsers/1001.jpg')

    },

    {name: 'Cat Damon',
    age: '30',
    occupation: 'actor',
    description: 'shakespeare is my middle name',
    imageName: require('../Assets/CatUsers/1002.jpg')
},

{name: 'Jennipurr Aniston',
    age: '21',
    occupation: 'truck driver',
    description: 'switching lanes on the freeway is my specialty',
    imageName: require('../Assets/CatUsers/1003.jpg')
},


{name: 'Fleas Witherspoon',
    age: '25',
    occupation: 'software developer',
    description: 'hello world!',
    imageName: require('../Assets/CatUsers/1004.jpg')
},

{name: 'Meowly Cyrus',
age: '27',
occupation: 'singer',
description: 'I placed 5th in Americat Idol!',
imageName: require('../Assets/CatUsers/1005.jpeg')
}



]

  },
  mutations: {
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user',JSON.stringify(user));
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
    }
  }
})
