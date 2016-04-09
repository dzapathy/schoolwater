package bean;

public class SearchTableContent {
	private String tableId; //关联表的ID
	private String lastContentId;//最后一个TableContentInfo的ID
	private String [] columnNames;//字段头
	private int limit;//查询数量
		
	public SearchTableContent() {
		super();
	}
	public SearchTableContent(String tableId, String lastContentId,
			String[] columnNames, int limit) {
		super();
		this.tableId = tableId;
		this.lastContentId = lastContentId;
		this.columnNames = columnNames;
		this.limit = limit;
	}
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
	public String getLastContentId() {
		return lastContentId;
	}
	public void setLastContentId(String lastContentId) {
		this.lastContentId = lastContentId;
	}
	public String[] getColumnNames() {
		return columnNames;
	}
	public void setColumnNames(String[] columnNames) {
		this.columnNames = columnNames;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
}
