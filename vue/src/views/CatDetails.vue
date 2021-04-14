<template>
  <div class="catdetails">
    <div>
    <router-link :to="{ name: 'addcat' }">Edit</router-link>
      <user-details></user-details>
    </div>
    <div>
     
      <send-message></send-message>
      
    </div>
  </div>
</template>

<script>

import SendMessage from "../components/SendMessage.vue";
import UserDetails from "../components/UserDetails.vue";

export default {


  
  name: "catdetails",
  components: {
    UserDetails,
    SendMessage,
    
   
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