package com.example.entity;
import java.util.Objects;
/**
 * 单人聊天
 */
public class ImSingle {

    private Integer id;
	/** 内容 */

	private String content;
	/** 发送人 */

	private String fromuser;
	/** 发送人头像 */

	private String fromavatar;
	/** 时间 */

	private String time;
	/** 类型 */

	private String type;
	/** 接收人 */

	private String touser;
	/** 接收人头像 */

	private String toavatar;
	/** 是否已读 */

	private Integer readed;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFromuser() {
		return fromuser;
	}

	public void setFromuser(String fromuser) {
		this.fromuser = fromuser;
	}

	public String getFromavatar() {
		return fromavatar;
	}

	public void setFromavatar(String fromavatar) {
		this.fromavatar = fromavatar;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTouser() {
		return touser;
	}

	public void setTouser(String touser) {
		this.touser = touser;
	}

	public String getToavatar() {
		return toavatar;
	}

	public void setToavatar(String toavatar) {
		this.toavatar = toavatar;
	}

	public Integer getReaded() {
		return readed;
	}

	public void setReaded(Integer readed) {
		this.readed = readed;
	}
}
