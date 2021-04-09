<template>
  <div id="nav">
    <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
    <router-link v-bind:to="{ name: 'cats' }">Cat List</router-link>&nbsp;|&nbsp;
    <router-link v-bind:to="{ name: 'account' }" v-if="$store.state.token == ''">Account</router-link>&nbsp;|&nbsp;
    <router-link v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''">Login</router-link>
    <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
    

  <router-view></router-view> 
  </div>
  
  
</template>

<script>
export default {};
</script>

<style>

#nav {
    font-size: 1.5em;
    text-align: center;
    margin: 1em;
}
</style>