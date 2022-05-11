package icm.lab1.homework1

import android.os.Bundle
import android.text.Editable
import android.view.View
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
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
                // do saved thing
            }
            R.id.saved2but -> {
                // do saved thing
            }
            R.id.saved3but -> {
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