class BluetoothServer extends Thread {
  BluetoothAdapter mBluetoothAdapter=null;
  String data=null;

  final Handler handler;
  final Runnable updateUI;

  public BluetoothServer(Handler handler, Runnable updateUI) {
    this.handler = handler;
    this.updateUI = updateUI;

    mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
  }

  public String getBluetoothServer() {
    return data;
  }

  public void run() {
    BluetoothServerSocket serverSocket;
    BluetoothSocket socket = null;
    try {
      serverSocket = mBluetoothAdapter.listenUsingRfcommWithServiceRecord("helloService", UUID.fromString("00001101-0000-1000-8000-00805F9B34FB"));
      
      socket = serverSocket.accept();
      data = "Accept connection";
      handler.post(updateUI);
      
      DataInputStream in = new DataInputStream(socket.getInputStream());
      DataOutputStream out = new DataOutputStream(socket.getOutputStream());
      data = in.readUTF();       // Read from client
      out.writeUTF("Echo "+data);   // Send to client
      handler.post(updateUI);
      
      Log.d("EchoServer", data);
        
      serverSocket.close();
      socket.close();
    } catch (Exception e) {}
  }
}

