<template>
  <div class="catdetails">
    <div>
      <user-details></user-details>
    </div>
  </div>
</template>

<script>


import UserDetails from "../components/UserDetails.vue";

export default {


  
  name: "catdetails",
  components: {
    UserDetails,
    
   
  },
   data() {
    return {
      firstTime: true,
    };
    
  },
  methods: {
    
  },
  created() {
    let catId = this.$route.params.id;

    // console.log("Outside if:" + catId)
    // if(catId == '') {
    //   this.firstTime = true;
    //    catId = this.$store.state.user.id;
    //    console.log("Inside if:" + catId)
    // }
    // this.firstTime = false;
    this.$store.commit("SET_CATID", catId);
  },
};
</script>

<style>
</style>