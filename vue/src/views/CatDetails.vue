<template>
  
  <div class="catdetails">
    <div>
      <user-details></user-details>
    </div>
    
    <div>
      <send-message></send-message>
    </div>
  </div>
  

</template>

<script>
import SendMessage from '../components/SendMessage.vue';
import UserDetails from '../components/UserDetails.vue';




export default {
  name: "catdetails",
  components: {
    UserDetails,
    SendMessage,
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