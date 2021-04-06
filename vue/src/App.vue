<template>
  <div id="app">
    <div id="nav">

      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{name:'cats'}">Cat List</router-link>
    </div>
   
    <router-view />
     <user-display />
    <the-footer></the-footer>
  </div>
</template>

<script>

import UserDisplay from "@/components/UserDisplay.vue"
import TheFooter from "@/components/TheFooter.vue"


export default {
  components: {

    
    UserDisplay,
    TheFooter,
    
  },
  
    
 };

</script>

