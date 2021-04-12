<template>
  <div id="nav" class="link">
    <router-link class="link1" style="text-decoration: none;" v-bind:to="{ name: 'home' }"><a>HOME</a></router-link>
    <router-link class="link2" style="text-decoration: none;" v-bind:to="{ name: 'cats' }"><a>CAT LIST</a></router-link>
    <router-link class="link3" style="text-decoration: none;" v-bind:to="{ name: 'account' }" v-if="$store.state.token == ''"><a>ACCOUNT</a></router-link> 
    <router-link class="link3" style="text-decoration: none;" v-bind:to="{ name: 'account' }" v-if="$store.state.token != ''"><a>ACCOUNT</a></router-link>
    <router-link class="link4" style="text-decoration: none;" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''"><a>LOGIN</a></router-link>
    <router-link class="link4" style="text-decoration: none;" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''"><a>LOGOUT</a></router-link>
  <router-view></router-view> 
  </div>
  
  
</template>

<script>
export default {};
</script>

<style>

.link {
  font-family: "Work Sans",sans-serif;
  font-size: 1.5em;
  text-align: right;
  margin: 1em 0em 10em 0em;
}

.link1 {
  margin: 1em;
}
.link2 {
  margin: 1em;
}
.link3 {
  margin: 1em;
}
.link4 {
  margin: 1em;
}

.link > a {
  position: relative;
  color: #000;
  text-decoration: none;
}
.link > a:hover {
  color: #000;
}

.link > a::before {
  content: "";
  position: absolute;
  width: 100%;
  height: 3px;
  bottom: 0;
  left: 0;
  background-color: rgb(0, 0, 0);
  visibility: hidden;
  transform: scaleX(0);
  transition: all 0.3s ease-in-out 0s;
}

.link > a:hover::before {
  visibility: visible;
  transform: scaleX(1);
}



</style>