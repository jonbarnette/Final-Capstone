<template>

  <div class="account">
    <!-- <h1>Welcome Back 'put cat/user name here'!</h1> -->
    <div class="welcome">
    <h1 v-if="$store.state.token != '' ">Welcome, {{$store.state.user.username}}</h1>
    </div>
    <div class="messageCatContainer">
      <div class="rMessage">
        <receive-message></receive-message>
      </div>
        <div class="plusCat">
      <add-cat></add-cat>
      </div>
    </div>
   
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

.welcome {
  display: flex;
  justify-content: center;
  font-size: 35px;
  font-family: 'Ledger', serif;
}
.rMessage {
  grid-area: rMessage;
  margin-left: 10%;
}
.plusCat {
  grid-area: plusCat;
}

.messageCatContainer {
  display: grid;
  grid-template-areas: 'rMessage plusCat'
  
}



/* * {
  background-image: url("../Assets/CatUsers/1015.jpg");
  background-position: center center;
  background-size: cover;
  background-repeat: no-repeat;
  background-attachment: fixed;
} */
</style>