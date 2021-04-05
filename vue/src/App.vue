<template>
  <div id="app">
    <div id="nav">

      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
      <router-link v-bind:to="{name:'cats'}">Cat List</router-link>
    </div>
   
    <router-view />
     <user-display />
    <user-list />
  </div>
</template>

<script>
import UserList from "@/components/UserList.vue";
import UserDisplay from "@/components/UserDisplay.vue"


export default {
  components: {

    UserList,
    UserDisplay
    
  },
  
    
 };

</script>

