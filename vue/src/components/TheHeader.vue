<template>
  <div class= "headCont">
    <div class="logo">
      <img src="../Assets/TabbyPro_Logo_250_100.png">
    </div>
    <div id="nav" class="link">
      <router-link class="link1" style="text-decoration: none;" v-bind:to="{ name: 'home' }"><a>HOME</a></router-link>
      <router-link class="link2" style="text-decoration: none;" v-bind:to="{ name: 'cats' }"><a>CAT LIST</a></router-link>
       
      <router-link class="link3" style="text-decoration: none;" v-bind:to="{ name: 'account' }" v-if="$store.state.token != ''"><a>ACCOUNT</a></router-link>
      <router-link class="link4" style="text-decoration: none;" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''"><a>LOGIN</a></router-link>
      <router-link class="link4" style="text-decoration: none;" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''"><a>LOGOUT</a></router-link>
    </div>
</div>
  
</template>

<script>
export default {};
</script>

<style>

.headCont{
  display: flex;
  flex-flow: row wrap;

}
.logo{
  justify-content: start;
  margin: auto;
}

.link {
  font-family: "Work Sans",sans-serif;
  font-size: 1.5em;
  margin: auto auto auto auto;

  justify-content: flex-end;
}

.link1 {
  justify-content: center;
  margin: 10px;
}
.link2 {
  justify-content: center;
  margin: 10px;
}
.link3 {
  justify-content: center;
  margin: 10px;
}
.link4 {
  justify-content: center;
  margin: 10px;
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