<template>
<div>
  <h2>Inbox</h2>
    <div id="userBio" v-for="msg in messageArray" v-bind:key="msg.catId">
      <div>{{msg.sender}}</div>
      <div>{{msg.message}}</div>
    </div>
</div>
</template>

<script>

import catService from "@/services/CatService.js";

export default {
  name: "receive-message",
  components: {},
  

  data() {
    return {
      messageArray: [],
      
    };
    
  },

  methods: {
    viewCatDetails() {
      this.$router.push("/catdetails");
    },
  },
    
  created() {
    const catId = this.$store.state.catId;

    catService
      .getCatMsg(catId)
      .then((response) => {
        console.log(response);
        console.log(response.data);

        this.messageArray = response.data;
      })
      .catch((error) => {
        console.log(error.statusMsg);
      });
  },
};



</script>



<style scoped>

</style>