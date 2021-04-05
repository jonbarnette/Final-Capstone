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
            <div class="divTableCell">
                <img class="image" v-bind:src="cat.imageName" />
            </div>
            
            <div class="divTableCell">{{ cat.name }}</div>
            <div class="divTableCell">{{ cat.age }}</div>
            <div class="divTableCell">{{ cat.occupation }}</div>
            <div class="divTableCell">{{ cat.description }}</div>
           
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
* {
  background-color: #16ffbd;
  color:  #C34271;
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


#main-div {
    margin: 30px;
}
#searchHomes {
    margin: 30px;
}

input[type=text] {
    margin: 30px;
    width: 10%;
    padding: 12px 14px;
    border: 2px solid green;
    border-radius: 6px;
}

div.minimalistBlack {
  margin: auto;
  border: 2px solid #06b712;
  width: 80%;
  text-align: left;
  border-collapse: collapse;
}
.divTable.minimalistBlack .divTableCell,
.divTable.minimalistBlack .divTableHead {
  border: 1px solid #000000;
  padding: 5px 4px;
  
}
.divTable.minimalistBlack .divTableBody .divTableCell {
  font-size: 30px;
  vertical-align: middle;
  text-align: center;
  
}
.divTable.minimalistBlack .divTableHeading {
  background: #1dff2c;
  background: -moz-linear-gradient(top, #55ff61 0%, #33ff41 66%, #1dff2c 100%);
  background: -webkit-linear-gradient(
    top,
    #55ff61 0%,
    #33ff41 66%,
    #1dff2c 100%
  );
  background: linear-gradient(to bottom, #55ff61 0%, #33ff41 66%, #1dff2c 100%);
  border-bottom: 3px solid #0f9a39;
}
.divTable.minimalistBlack .divTableHeading .divTableHead {
  font-size: 30px;
  font-weight: bold;
  color: #109902;
  text-align: center;
}
.minimalistBlack .tableFootStyle {
  font-size: 14px;
}
/* DivTable.com */
.divTable {
  display: table;
  table-layout: fixed;
}
.divTableRow {
  display: table-row;
}
.divTableHeading {
  display: table-header-group;
}
.divTableCell,
.divTableHead {
  display: table-cell;
  
}
.divTableHeading {
  display: table-header-group;
}
.divTableFoot {
  display: table-footer-group;
}
.divTableBody {
  display: table-row-group;
}
</style>