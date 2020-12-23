<form action="/dashboards/57" method="get">

<h2><center>My Parameterized Report</center></h2>

<input type="hidden" name="run" value="1" />

<div style="display:flex">

  <div style="margin:0 1em">

    <select type="text" id="myform-state" name="Department">

      <option value="Men">Men</option>

      <option value="Women">Women</option>

    </select>

    <br /><label for="myform-state" style="color:#AAA;font-size:0.8em"> Department</label><br />

  </div>

  <div style="margin:0 1em">

    <input type="text" id="myform-city" name="City" /><br />

    <label for="myform-city" style="color:#AAA;font-size:0.8em">City</label>

  </div>

  <div style="margin:0 1em">

    <input type="date" id="myform-date" name="Date" /><br />

    <label for="myform-date" style="color:#AAA;font-size:0.8em">Date</label>

  </div>

  <div style="margin:0 1em">

   <input type="submit" value="Go" name="" style="height:2em" />

  </div>

</div>

<details>

  <summary>More Options</summary>

  <table>



  <tr><td><label for="myform-opt0">Datetime: </label></td>

  <td><input type="datetime-local" id="myform-opt0" name="My_Datetime" /></td></tr>

  <tr><td><label for="myform-opt1">Month: </label></td>

  <td><input type="month" id="myform-opt1" name="My_Month" /></td></tr>

  <tr><td><label for="myform-opt2">Number: </label></td>

  <td><input type="number" id="myform-opt2" name="My_Number" min="1" step="1" max="10" /></td></tr>

  <tr><td><label for="myform-opt3">Range: </label></td>

  <td><input type="range" id="myform-opt3" name="My_Range" /></td></tr>

  <tr><td><label for="myform-opt4">Email: </label></td>

  <td><input type="email" id="myform-opt4" name="My_Email" /></td></tr>

  <tr><td><b>Pick one:</b></td>

  <td>

  <input type="radio" id="myform-mode-day" name="Mode" value="d" checked="checked" />

  <label for="myform-mode-day" >Day</label> &nbsp;

  <input type="radio" id="myform-mode-week" name="Mode" value="w" />

  <label for="myform-mode-week">Week</label> &nbsp;

  <input type="radio" id="myform-mode-month" name="Mode" value="m" />

  <label for="myform-mode-month">Month</label>

  </td></tr>

  <tr><td><b>Pick any:</b></td>

  <td>

  <input type="checkbox" id="myform-check-a" name="Checks" value="web" checked="checked" />

  <label for="myform-check-a" >Web</label> &nbsp;

  <input type="checkbox" id="myform-check-b" name="Checks" value="android" checked="checked"  />

  <label for="myform-check-week">Android</label> &nbsp;

  <input type="checkbox" id="myform-check-c" name="Checks" value="ios" checked="checked"  />

  <label for="myform-check-c">iOS</label>

  </td></tr>

</details>

</form>
