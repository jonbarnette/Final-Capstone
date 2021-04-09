<template>
  
  <div class="catdetails">
    <h1>Put Details Here Meow!</h1>
  
    <user-details></user-details>
   
    <!-- <p>Under Catstruction. Please excuse the meows</p>
    <img class="water-cat" src='../Assets/CatUsers/1015.jpg' /> -->
  </div>
  

</template>

<script>
import UserDetails from '../components/UserDetails.vue'

export default {
  name: "catdetails",
  components: {
    UserDetails
  }, 
  created() {
    const catId = this.$route.params.id;
    this.$store.commit("SET_CATID", catId);
  }
};
</script>

<style>
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

/* * {
  background-image: url("../Assets/CatUsers/1015.jpg");
  background-position: center center;
  background-size: cover;
  background-repeat: no-repeat;
  background-attachment: fixed;
} */
</style>