<template>
 
<div class="msgcontainer">
    
    <form class="sendMsg" @submit.prevent="sendMsg">
      <label for="fname">Sender Name</label>
      <input type="text" id="fname" name="name" v-model="cat.sender" placeholder="Sender name.." />

      
      <label for="summary">Message</label>
      <textarea
        id="message"
        name="message"
        v-model="cat.message"
        placeholder="Type your message here.."
        style="height: 100px"
        required
      ></textarea>
     <button type="submit" class="sendMsgButton" value="Send Message">Send Message</button>
    </form>
    
    
</div>
</template>


<script>
import catService from "../services/CatService";

export default {
  name: "send-message",

  data() {
    return {
      
    };
  },
  methods: {
    sendMsg() {
      catService
        .msgCat(this.cat)
        .then((response) => {
          console.log(response.status);
          if (response.status == "201") {
              console.log("Message sent")
            //success
          }
        })
        .catch((error) => {
          // handle an error
          console.log(error);
        });
  },
  },
};


</script>

<style scoped>
* {
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}

input[type="text"], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

::placeholder {
  color: black;
}
input[type="submit"] {
  background-color: #4caf50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  width: 10em;
}
input[type="submit"]:hover {
  background-color: #45a049;
}
.msgcontainer5, form{
  border-radius: 5px;
  background-color: #163DA1;
  padding: 20px;
  font-family: monospace;
  width: 25em;
  margin: 0 auto;
  align-items: center;
}
</style>