package icm.lab1.homework1

import android.app.Dialog
import android.content.DialogInterface
import android.os.Bundle
import android.text.Editable
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat.recreate
import androidx.fragment.app.DialogFragment

val saved1data = arrayListOf<String>("","")
val saved2data = arrayListOf<String>("","")
val saved3data = arrayListOf<String>("","")

class MainActivity : AppCompatActivity() {

    fun updateSpeedDialNames(){
        if(saved1data[0]!="")
            if (findViewById<Button>(R.id.saved1But).text.length > 4)
            findViewById<Button>(R.id.saved1But).text = saved1data[0].toCharArray()[0].toString()
        else
                findViewById<Button>(R.id.saved1But).text = saved1data[0]

        else
            findViewById<Button>(R.id.saved1But).text = "~"
        if(saved2data[0]!="")
            if (findViewById<Button>(R.id.saved2but).text.length > 4)
                findViewById<Button>(R.id.saved2but).text = saved2data[0]
            else
                findViewById<Button>(R.id.saved2but).text = saved2data[0].toCharArray()[0].toString()
        else
            findViewById<Button>(R.id.saved2but).text = "~"

        if(saved3data[0]!="")
            if (findViewById<Button>(R.id.saved3but).text.length > 4)
                findViewById<Button>(R.id.saved3but).text = saved3data[0]
            else
                findViewById<Button>(R.id.saved3but).text = saved3data[0].toCharArray()[0].toString()

        else
            findViewById<Button>(R.id.saved3but).text = "~"

    }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val saved1 = findViewById<Button>(R.id.saved1But);
        val saved2 = findViewById<Button>(R.id.saved2but);
        val saved3 = findViewById<Button>(R.id.saved3but);

        saved1.setOnLongClickListener{
            SpeedDialDialogFragment("1").show(
                supportFragmentManager, SpeedDialDialogFragment.TAG
            )
            if(saved1data[0]!="")
                saved1.text = saved1data[0].toCharArray()[0].toString()

            false // Don't consume event, if return false. Consume event if true.
        }

        saved2.setOnLongClickListener{
            SpeedDialDialogFragment("2").show(
                supportFragmentManager, SpeedDialDialogFragment.TAG
            )

            false // Don't consume event, if return false. Consume event if true.
        }
        saved3.setOnLongClickListener{
            SpeedDialDialogFragment("3").show(
                supportFragmentManager, SpeedDialDialogFragment.TAG
            )

            false // Don't consume event, if return false. Consume event if true.
        }
    }


    fun clickHandlerFunction(view: View) {
        val editNum = findViewById<EditText>(R.id.phoneNumText)

        when (view.id) {
            R.id.Num1 -> {
                editNum.text=editNum.text.append("1")
            }
            R.id.num2 -> {
                editNum.text=editNum.text.append("2")

            }
            R.id.num3 -> {
                editNum.text=editNum.text.append("3")

            }
            R.id.num4 -> {
                editNum.text=editNum.text.append("4")

            }
            R.id.num5 -> {
                editNum.text=editNum.text.append("5")

            }
            R.id.num6 -> {
                editNum.text=editNum.text.append("6")

            }
            R.id.num7 -> {
                editNum.text=editNum.text.append("7")

            }
            R.id.num8 -> {
                editNum.text=editNum.text.append("8")

            }
            R.id.num9 -> {
                editNum.text=editNum.text.append("9")

            }
            R.id.num0 -> {
                editNum.text=editNum.text.append("0")

            }
            R.id.plusBut -> {
                editNum.text=editNum.text.append("+")

            }
            R.id.cardinalBut -> {
                editNum.text=editNum.text.append("#")

            }
            R.id.phoneNumDel -> {
                editNum.text= editNum.text.dropLast(1) as Editable?
            }
            R.id.saved1But -> {
               // Log.d("","AAAAAAAAAAAAAAAAAAAAAAAAA")
               // Log.d("",saved1data.toString())
                if( saved1data[0]!=""){
                    editNum.setText(saved1data[1])
                }
                // do saved thing
            }
            R.id.saved2but -> {
                if( saved2data[0]!=""){
                    editNum.setText(saved2data[1])
                }
                // do saved thing
            }
            R.id.saved3but -> {
                if( saved3data[0]!=""){
                    editNum.setText(saved3data[1])
                }
                // do saved thing
            }
            R.id.callBut -> {
                // do call thing
            }
            else -> {
                editNum.text=editNum.text.append("?")

            }
        }

    }

}

class SpeedDialDialogFragment( num:String) : DialogFragment()  {
    val num = num;

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        return activity?.let {
            val builder = AlertDialog.Builder(it,R.style.dialogTheme)
            // Get the layout inflater
            val inflater = requireActivity().layoutInflater;

            // Inflate and set the layout for the dialog
            // Pass null as the parent view because its going in the dialog layout
            val v = inflater.inflate(R.layout.speedial_dialog, null)
            builder.setView(v)
                // Add action buttons
                .setPositiveButton(R.string.confirm,
                    DialogInterface.OnClickListener { dialog, id ->
                        // add number
                        val label = v.findViewById<EditText>(R.id.label)
                        val number = v.findViewById<EditText>(R.id.number)

                        when(num){
                            "1" -> {saved1data.clear()
                                Log.d("", label.text.toString())
                                if (label != null) {
                                    saved1data.add(label.text.toString())
                                }
                                if (number != null) {
                                    saved1data.add(number.text.toString())
                                }
                            }
                            "2" -> {saved2data.clear()
                                if (label != null) {
                                    saved2data.add(label.text.toString())
                                }
                                if (number != null) {
                                    saved2data.add(number.text.toString())
                                }

                            }
                            "3" -> {saved3data.clear()
                                if (label != null) {
                                    saved3data.add(label.text.toString())
                                }
                                if (number != null) {
                                    saved3data.add(number.text.toString())
                                }

                            }
                        }
                        (activity as MainActivity?)!!.updateSpeedDialNames()

                            getDialog()?.dismiss()

                    })
                .setNegativeButton(R.string.cancel,
                    DialogInterface.OnClickListener { dialog, id ->
                        getDialog()?.cancel()
                    })
            builder.create()
        } ?: throw IllegalStateException("Activity cannot be null")
    }
    companion object {
        const val TAG = "SpeedDialDialog"
    }

}