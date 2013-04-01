import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothServerSocket;
import android.bluetooth.BluetoothSocket;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.util.UUID;
import android.widget.ArrayAdapter;
//Variables:
  PImage img;
int state = 0;
BluetoothServer bluetoothServer;
ArrayAdapter mArrayAdapter;
final Handler handler = new Handler();
final Runnable updateUI = new Runnable() {
    public void run() {
      mArrayAdapter.add(bluetoothServer.getBluetoothServer());
       
    }
};
//Procedure
void setup(){
  bluetoothServer = new BluetoothServer(handler, updateUI);
        bluetoothServer.start();
}
void draw(){

   background(0);
    image(img,0,0);
}
