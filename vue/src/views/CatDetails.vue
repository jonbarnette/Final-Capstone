<template>
  
  <div class="catdetails">
   
  
    <user-details></user-details>
    
    <!-- <p>Under Catstruction. Please excuse the meows</p>
    <img class="water-cat" src='../Assets/CatUsers/1015.jpg' /> -->
  </div>
  

</template>

<script>
import UserDetails from '../components/UserDetails.vue';



export default {
  name: "catdetails",
  components: {
    UserDetails,
    
  }, 
  methods: {

  },
  created() {
    const catId = this.$route.params.id;
    this.$store.commit("SET_CATID", catId);
  },
  
};
</script>

<style>

</style>