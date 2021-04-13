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

button[type="submit"] {
  background-color: #d6dae6;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  width: 7.313%;
  height: 2%;
  position:absolute;
  top: 2em;
  right: 5em;
}
button[type="submit"]:hover {
  background-color: #ff0000;
  color: #163DA1;
}
.detailImage {
  display: block;
  width: 300px !important;
  height: 250px;
  margin-left: auto;
  margin-right: auto;
  margin-top: 1em;
  border-radius: 50%;
}
* {
  display:flex;
  flex-direction: column;
}
</style>