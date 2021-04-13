<template>
<div>
  <h2 class="inbox">Inbox</h2>
    <div id="rcvMsg" v-for="msg in messageArray" v-bind:key="msg.catId">
      <div class="msg-sender">{{msg.sender}}: </div>
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
.msg-sender {
  grid-area: msg-sender;
  padding-left: 15px;
  margin-right: 10px;
  font-size: 1.5em;
}
.the-msg {
  grid-area: the-msg;
  padding-right: 15px;
  margin-left: 10px;
  font-size: 1.5em;
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
</style>