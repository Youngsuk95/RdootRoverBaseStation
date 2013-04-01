class BluetoothServer extends Thread {
  BluetoothAdapter mBluetoothAdapter=null;
  String data=null;
   BluetoothServerSocket serverSocket;
    BluetoothSocket socket = null;
    DataInputStream in;
    DataOutputStream out;
    int size;
    final Handler handler;
  final Runnable updateUI;

  byte[] imgData;
  public BluetoothServer(Handler handler, Runnable updateUI) {
   this.handler = handler;
    this.updateUI = updateUI;

    mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
  }

  public String getBluetoothServer() {
    return " ";
  }

  public void run(){
   
    try {
      
      serverSocket = mBluetoothAdapter.listenUsingRfcommWithServiceRecord("helloService", UUID.fromString("00001101-0000-1000-8000-00805F9B34FB"));
      socket = serverSocket.accept();
      state = 1;
      in  = new DataInputStream(socket.getInputStream());
      out = new DataOutputStream(socket.getOutputStream());
      byte[] read = new byte[size];
      int length = in.read () << 8;
      length |= in.read ();
      
      imgData = new byte[length];
      length = 0;
      
      while (length != imgData.length) {
           int n = in.read (imgData, length, imgData.length - length);
           if (n == -1) {
                        throw new IOException ("Can't read a image data");
           }

          length += n;
      }
    
      img = new PImage(imgData);
      handler.post(updateUI);
       serverSocket.close();
      socket.close(); 
      }
      catch (Exception e) {
      }
       
      
  }
  }


