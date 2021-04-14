<template>
<div>
  <h2 class="inbox">Inbox</h2>
    <div id="rcvMsg" v-for="msg in messageArray" v-bind:key="msg.catId">
      <div class="msg-sender"><img src="../Assets/CatUsers/1011.jpg" alt="Avatar" class="right">{{msg.sender}}: </div>
       
      <div class="the-msg">{{msg.message}}</div>
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

  methods: {},
    
  created() {
    let catId = this.$store.state.catId;
  console.log('mycatid is:' + catId);
  
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
.msg-sender {
  grid-area: msg-sender;
  /* padding-left: 15px;
  margin-right: 10px; */
  font-size: 1.5em;
  padding: 10px;
  margin: 10px 0;
  border: 2px solid #575353;
  background-color: #c0b9b9;
  border-radius: 15px;
  padding: 10px;
  margin: 10px 0;
}
.the-msg {
  grid-area: the-msg;
  /* padding-right: 15px;
  margin-left: 10px; */
  font-size: 1.5em;
  border: 2px solid #575353;
  background-color: #f1f1f1;
  border-radius: 15px;
  padding: 10px;
  margin: 10px 0;
  box-shadow: 5px 5px #575353;
}
#rcvMsg {
  display: grid;
  grid-template-areas: 'msg-sender the-msg';
  border: 2px solid transparent;
  width: fit-content;
}
.inbox {
  margin-left: 45%;
  font-size: 2.5em;
}
.msg-sender img {
    float: left;
  max-width: 60px;
  width: 100%;
  margin-right: 20px;
  border-radius: 50%;

}
</style>