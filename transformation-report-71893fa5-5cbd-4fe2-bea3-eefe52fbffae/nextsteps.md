# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without any reported issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-breaking, may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Avoid `net48` or other Windows-only framework monikers if cross-platform support is required.

### 4. Check for Windows-Specific Dependencies

Search the project for any remaining references to Windows-specific APIs or packages, such as:

- `System.Web`
- `Microsoft.Web.*`
- `System.Drawing` (without the `System.Drawing.Common` NuGet package)
- Any P/Invoke calls targeting Windows-only libraries

These will not cause build errors on Windows but will fail at runtime on Linux or macOS.

### 5. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application manually or via a browser to verify that core functionality behaves as expected.

### 6. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests, as they may indicate runtime behavioral differences between the legacy .NET Framework and the new cross-platform .NET runtime.

### 7. Verify Configuration Files

- Confirm that `appsettings.json` (or equivalent) contains all configuration values that were previously in `web.config` or `app.config`.
- Check that connection strings, API keys, and environment-specific settings have been correctly migrated.
- If `web.config` transforms were used previously, ensure equivalent behavior is handled through `appsettings.{Environment}.json` files or environment variables.

### 8. Validate Static Files and Middleware

If this is a web project, verify that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Confirm that any HTTP modules or HTTP handlers from the legacy project have been replaced with the appropriate ASP.NET Core middleware.

### 9. Database and Entity Framework Checks

If the project uses Entity Framework, confirm:

- The correct EF Core version is referenced.
- Migrations exist and are up to date by running:

```bash
dotnet ef migrations list
```

- The database schema matches expectations by running:

```bash
dotnet ef database update
```

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, configuration files, and binaries are present before deploying to the target environment.