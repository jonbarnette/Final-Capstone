<template>

  <div class="account">
    <!-- <h1>Welcome Back 'put cat/user name here'!</h1> -->
    <p v-if="$store.state.token != '' ">Welcome {{$store.state.user.username}}</p>
    
    <receive-message></receive-message>
  <add-cat></add-cat>
   
  </div>
  

</template>

<script>

import AddCat from '../components/AddCat.vue';
import ReceiveMessage from '../components/ReceiveMessage.vue';



export default {
  name: "account",
  components: {
    AddCat,
    ReceiveMessage,
  },

  data() {
    return {};
  }

};
</script>

<style scoped>
.water-cat {
  height: 50%;
  width: 50%;
  display: block;
  margin-left: auto;
  margin-right: auto;
}

.home {
  text-align: center;
}

#delete {
  font-size: .5em;

}

/* * {
  background-image: url("../Assets/CatUsers/1015.jpg");
  background-position: center center;
  background-size: cover;
  background-repeat: no-repeat;
  background-attachment: fixed;
} */
</style>