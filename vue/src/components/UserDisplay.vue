<template>
  <!-- <div class="background">

  <div>
   <img class="catimage"

   src="../Assets/CatUsers/3000.jpg"
   
   />


  </div>
  
  </div> -->
<div>
    <div id="searchUsers">
        <label for="occupation">Enter occupation:</label>
        <input type="text" name="occupation" v-model="occupationFilter" />
            
    </div>
<div id="main-div">
      <div class="divTable minimalistBlack" v-show="filteredCats.length > 0">
        <div class="divTableHeading">
          <div class="divTableRow">
            <div class="divTableHead"></div>
            <div class="divTableHead">Name</div>
            <div class="divTableHead">Age</div>
            <div class="divTableHead">Occupation</div>
            <div class="divTableHead">Description</div>
          
          </div>
        </div>
        <div class="divTableBody">
          <div class="divTableRow" v-for="cat in filteredCats" v-bind:key="cat.name">
            <div class="divTableImage">
                <img class="image" v-bind:src="cat.imageName" />
            </div>
            <div class="overlay">
            <div class="divTableCell">{{ cat.name }}</div>
            <div class="divTableCell">{{ cat.age }}</div>
            <div class="divTableCell">{{ cat.occupation }}</div>
            <div class="divTableCell">{{ cat.description }}</div>
           </div>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
export default {

  name: "user-display",
  props: ["user"],
data() {
    return {
      occupationFilter: "",
    };
  },
  computed: {
    filteredCats() {
      const filteredCats = this.$store.state.catlist;
      console.log(filteredCats);
      return filteredCats.filter((cat) => {
        return this.occupationFilter === ""
          ? true
          : this.occupationFilter === cat.occupation;
      });
    },
  },

};


</script>



<style>
.catimage {
  display: block;
  margin-left: auto;
  margin-right: auto;
  height: 50em;
  width: auto;
}
* {
  background-color: #16ffbd;
  color:  #C34271;
}

.divTableImage {
  position: relative;
  width: 50%;
}

.image {
  display: block;
  width: 100%;
  height: auto;
}

/* .overlay {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
  opacity: 0;
  transition: .5s ease;
  background-color: #008CBA;
} */

/* .container:hover .overlay {
  opacity: 1;
} */

/* .divTableCell {
  color: white;
  font-size: 20px;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  text-align: center;
} */
</style>