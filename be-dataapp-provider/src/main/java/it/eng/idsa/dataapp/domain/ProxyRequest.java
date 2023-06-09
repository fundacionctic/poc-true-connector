package it.eng.idsa.dataapp.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * Class to wrap up data needed for proxy request logic
 * 
 * @author igor.balog
 *
 */
public class ProxyRequest {
	public static final String MULTIPART_MIXED = "mixed";
	public static final String MULTIPART_FORM = "form";
	public static final String MULTIPART_HEADER = "http-header";
	public static final String WSS = "wss";

	private String multipart;
	private String forwardTo;
	private String forwardToInternal;
	private String payload;
	private String requestedArtifact;
	private String messageType;
	private String requestedElement;
	private String transferContract;

	public ProxyRequest() {
		super();
	}

	public ProxyRequest(String multipart, String forwardTo, String forwardToInternal, String payload,
			String requestedArtifact, String messageType, String requestedElement, String transferContract) {
		super();
		this.multipart = multipart;
		this.forwardTo = forwardTo;
		this.forwardToInternal = forwardToInternal;
		this.payload = payload;
		this.requestedArtifact = requestedArtifact;
		this.messageType = messageType;
		this.requestedElement = requestedElement;
		this.transferContract = transferContract;
	}

	public String getMultipart() {
		return multipart;
	}

	public void setMultipart(String multipart) {
		this.multipart = multipart;
	}

	public String getPayload() {
		return payload;
	}

	public void setPayload(String payload) {
		this.payload = payload;
	}

	public String getRequestedArtifact() {
		return requestedArtifact;
	}

	public void setRequestedArtifact(String requestedArtifact) {
		this.requestedArtifact = requestedArtifact;
	}

	public String getForwardTo() {
		return forwardTo;
	}

	public void setForwardTo(String forwardTo) {
		this.forwardTo = forwardTo;
	}

	public String getForwardToInternal() {
		return forwardToInternal;
	}

	public void setForwardToInternal(String forwardToInternal) {
		this.forwardToInternal = forwardToInternal;
	}

	public String getMessageType() {
		return messageType;
	}

	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}

	public String getRequestedElement() {
		return requestedElement;
	}

	public void setRequestedElement(String requestedElement) {
		this.requestedElement = requestedElement;
	}

	public String getTransferContract() {
		return transferContract;
	}

	public void setTransferContract(String transferContract) {
		this.transferContract = transferContract;
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("multipart", this.multipart)
				.append("forwardTo", this.forwardTo)
				.append("forwardToInternal", this.forwardToInternal)
				.append("payload", this.payload)
				.append("requestedArtifact", this.requestedArtifact)
				.append("messageType", this.messageType)
				.append("requestedElement", this.requestedElement)
				.append("transferContract", this.transferContract)
				.toString();
	}
}
