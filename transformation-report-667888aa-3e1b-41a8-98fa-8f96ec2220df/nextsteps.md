# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The following steps outline how to validate, test, and deploy the migrated `GadgetsOnline` project.

---

## 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

---

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment.

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

---

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` is set to a current and supported version of .NET, such as `net8.0`.

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider upgrading to `net8.0` as those versions are approaching or have reached end of life.

---

## 4. Check for Removed or Changed APIs

Legacy ASP.NET projects often rely on APIs that have changed significantly in cross-platform .NET. Manually review the following areas:

- **`System.Web` dependencies**: These are not available in .NET Core or later. Ensure all usages have been replaced with their `Microsoft.AspNetCore` equivalents.
- **`HttpContext`**: Verify it is accessed via dependency injection rather than `HttpContext.Current`.
- **`Session` and `Cache`**: Confirm replacements using `IHttpContextAccessor`, `IMemoryCache`, or `IDistributedCache`.
- **`ConfigurationManager`**: Ensure it has been replaced with `IConfiguration` and `appsettings.json`.

---

## 5. Run the Application Locally

Start the application locally to verify runtime behavior.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm that pages render correctly and core functionality operates as expected.

---

## 6. Validate Database Connectivity

If the project uses Entity Framework or direct database access, confirm the connection strings in `appsettings.json` are correct and that the database is reachable.

```bash
dotnet ef database update
```

If Entity Framework migrations are present, run them to ensure the schema is up to date.

---

## 7. Execute Existing Tests

If the solution contains test projects, run them to verify that existing functionality has not regressed.

```bash
dotnet test
```

Review any failing tests and determine whether they are failing due to migration-related changes or pre-existing issues.

---

## 8. Review Static Files and Middleware Configuration

In cross-platform .NET, static files and middleware must be explicitly configured in `Program.cs` or `Startup.cs`. Confirm the following are present where applicable:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
```

---

## 9. Verify Publish Output

Perform a publish to confirm the output is complete and correct before any deployment.

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all necessary files, including static assets and configuration files, are present.

---

## 10. Review Logging and Error Handling

Confirm that logging is configured correctly in `appsettings.json` and `Program.cs`, and that unhandled exceptions are surfaced appropriately in both development and production environments.

```json
"Logging": {
  "LogLevel": {
    "Default": "Information",
    "Microsoft.AspNetCore": "Warning"
  }
}
```