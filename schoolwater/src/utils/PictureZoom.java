package utils;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.awt.image.ConvolveOp;
import java.awt.image.Kernel;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.swing.ImageIcon;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
/**
 * 缩放效果不错，但是只能按等比例缩放，
 * 也可以修改成自设置长宽。
 * @author lliangx
 *
 */
public class PictureZoom {	
	/**
	 * 图片剪裁
	 * @param src
	 * @param dest
	 * @param x
	 * @param y
	 * @param w
	 * @param h
	 * @throws IOException
	 */
	//剪裁图片android
	public static File cutImage(File src,File dest) throws IOException{   
        Iterator<ImageReader> iterator = ImageIO.getImageReadersByFormatName("jpg");   
        ImageReader reader = (ImageReader)iterator.next();   
        InputStream in=new FileInputStream(src);  
        ImageInputStream iis = ImageIO.createImageInputStream(in);   
        reader.setInput(iis, true);   
        ImageReadParam param = reader.getDefaultReadParam(); 
        ImageIcon ii = new ImageIcon(src.getCanonicalPath());
		Image i = ii.getImage();
		int x=0,y=0,w=0,h=0;
		if(i.getWidth(null)*0.66<i.getHeight(null)){ //宽的0.66小于高		
			w =i.getWidth(null);			
			h=(int)(w*0.66);
			x=0;
			y=(int) (i.getHeight(null)-h)/2;
		}else{	//宽的0.66大于高
			h=i.getHeight(null);
			w=(int)(i.getHeight(null)/0.66);
			x=(int)(i.getWidth(null)-w)/2;
			y=0;
		}
        Rectangle rect = new Rectangle(x, y, w,h);    
        param.setSourceRegion(rect);   
        BufferedImage bi = reader.read(0,param);     
        ImageIO.write(bi, "jpg", dest); 
        in.close();
        iis.close();
        return dest;
	}
	
	//剪裁图片web
	public static File cutImageWeb(File src,File dest) throws IOException{
		Iterator<ImageReader> iterator = ImageIO.getImageReadersByFormatName("jpg");   
        ImageReader reader = (ImageReader)iterator.next();   
        InputStream in=new FileInputStream(src);  
        ImageInputStream iis = ImageIO.createImageInputStream(in);   
        reader.setInput(iis, true);   
        ImageReadParam param = reader.getDefaultReadParam(); 
        ImageIcon ii = new ImageIcon(src.getCanonicalPath());
		Image i = ii.getImage();
		int x=0,y=0,w=0,h=0;
		if(i.getWidth(null)<i.getHeight(null)){ //宽小于高		
			w =i.getWidth(null);			
			h=w;
			x=0;
			y=(int) (i.getHeight(null)-h)/2;
		}else{	//宽的0.66大于高
			h=i.getHeight(null);
			w=h;
			x=(int)(i.getWidth(null)-w)/2;
			y=0;
		}
        Rectangle rect = new Rectangle(x, y, w,h);    
        param.setSourceRegion(rect);   
        BufferedImage bi = reader.read(0,param);     
        ImageIO.write(bi, "jpg", dest); 
        in.close();
        iis.close();
        return dest;
	}

	public static File resize(File originalFile, File resizedFile,
			int newWidth,int newHight, float quality) throws IOException {
		if (quality > 1) {
			throw new IllegalArgumentException(
					"Quality has to be between 0 and 1");
		}
		ImageIcon ii = new ImageIcon(originalFile.getCanonicalPath());
		Image i = ii.getImage();
		Image resizedImage = null;
		int iWidth = i.getWidth(null);
		int iHeight = i.getHeight(null);
		//等比例设置长宽
		if (iWidth > iHeight) {
			resizedImage = i.getScaledInstance(newWidth, (newWidth * iHeight)
					/ iWidth, Image.SCALE_SMOOTH);
		} else {
			resizedImage = i.getScaledInstance((newWidth * iWidth) / iHeight,
					newWidth, Image.SCALE_SMOOTH);
		}
		//可自己设置长宽
		//resizedImage = i.getScaledInstance(newWidth, newHight, Image.SCALE_SMOOTH);
		// This code ensures that all the pixels in the image are loaded.
		Image temp = new ImageIcon(resizedImage).getImage();
		// Create the buffered image.
		BufferedImage bufferedImage = new BufferedImage(temp.getWidth(null),
				temp.getHeight(null), BufferedImage.TYPE_INT_RGB);
		// Copy image to buffered image.
		Graphics g = bufferedImage.createGraphics();
		// Clear background and paint the image.
		g.setColor(Color.white);
		g.fillRect(0, 0, temp.getWidth(null), temp.getHeight(null));
		g.drawImage(temp, 0, 0, null);
		g.dispose();
		// Soften.
		float softenFactor = 0.05f;
		float[] softenArray = { 0, softenFactor, 0, softenFactor,
				1 - (softenFactor * 4), softenFactor, 0, softenFactor, 0 };
		Kernel kernel = new Kernel(3, 3, softenArray);
		ConvolveOp cOp = new ConvolveOp(kernel, ConvolveOp.EDGE_NO_OP, null);
		bufferedImage = cOp.filter(bufferedImage, null);
		// Write the jpeg to a file.
		FileOutputStream out = new FileOutputStream(resizedFile);
		// Encodes image as a JPEG data stream
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		JPEGEncodeParam param = encoder
				.getDefaultJPEGEncodeParam(bufferedImage);
		param.setQuality(quality, true);
		encoder.setJPEGEncodeParam(param);
		encoder.encode(bufferedImage);
		out.close();
		return resizedFile;
	} // Example usage
	
	//测试
	public static void main(String[] args) throws IOException {
//		 File originalImage = new File("C:\\11.jpg");
//		 resize(originalImage, new File("c:\\11-0.jpg"),150, 0.7f);
//		 resize(originalImage, new File("c:\\11-1.jpg"),150, 1f);
		 File originalImage = new File("H:\\picture\\02.jpg");
		 //resize(originalImage, new File("H:\\picture\\test1.jpg"),300, 0,0.8f);
		 //resize(originalImage, new File("H:\\picture\\test2.jpg"),300,0, 1f);
		 cutImage(originalImage,new File("H:\\picture\\10-1.jpg"));
	}
}
