<template>

  <div class="account">
    
    <h1>Welcome Back nya!</h1>
    <p>Under Catstruction. Please excuse the meows</p>
    <img class="water-cat" src='../Assets/CatUsers/1015.jpg' />
  
    <router-link id="delete" v-bind:to="{ name: 'delete' }">Delete Account</router-link>
  </div>
  

</template>

<script>

export default {
  name: "account",
  components: {
    
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
